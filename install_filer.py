from pathlib import Path
from subprocess import run, PIPE
import getpass, shutil, sys, filecmp
from datetime import datetime

def read_username_and_pass(file: Path):
    d = {}
    with file.open("r") as f:
        lines = f.readlines()
        for l in lines:
            eq_index = l.index("=")
            key = l[:eq_index]
            value = l[eq_index+1:-1]
            d[key] = value
    return d

def get_credentials_from_user(file: Path, **kwargs):
    d = {}
    d.update(kwargs)
    d["username"] = input("Please give us your username (of the form Tx-FirstnameL)")
    d["password"] = getpass.getpass("Please give us your password")
    with file.open("w") as f:
        for k, v in d.items():
            f.write(f"{k}={v}\n")

credentials_file = Path("/root/.filersmbcredentials")
credentials_file.parent.mkdir(exist_ok=True, parents=True)

credentials_done=False
while not credentials_done:
    try:
        d = read_username_and_pass(credentials_file)
        password = d["password"]
        user = d["username"]
        domain = d["domain"]
        print(f"Retrieved credentials from {credentials_file}. Choose one of the following actions:")
        decided=False
        while not decided:
            r = input("1. Press c to continue.\n2. Press d to erase these credentials and enter new ones.\n3. Press v to view these credentials and then decide.\n")
            match r.lower():
                case "c":
                    credentials_done = True
                    decided=True
                case "d":
                    credentials_file.unlink()
                    decided=True
                case "v":
                    print(d)

    except:
        print(f"No valid credential file already found at {credentials_file}. Requesting credentials to create file...")
        get_credentials_from_user(credentials_file, domain="imn.u-bordeaux2.fr")

run(["chmod", "600", str(credentials_file)])
print("Installing required packages. You may be prompted by a scary screen for keberos installation. If so, do not enter anything and select OK (i.e press ENTER)")
print("You may also have a cifs error at somepoint and typing if 'modprobe cifs' indicates that cifs is not installed, please do 'sudo apt-get install cifs-util linux-modules-extra-aws' and reboot")
input("Press any key to continue")
run("apt install -y keyutils cifs-utils krb5-user krb5-config libkrb5-dev".split(" "))


krb5_file = Path(sys.argv[0]).parent/"krb5.conf"
krb5destpath = Path("/etc/krb5.conf")
if not krb5destpath.exists() or not filecmp.cmp(krb5_file, krb5destpath):
    print("etc/krb5.conf is being updated")
    if krb5destpath.exists():
        oldkrb5 = krb5destpath.with_stem(krb5destpath.stem+datetime.today().strftime('%Y-%m-%d'))
        shutil.copy(krb5destpath, oldkrb5) 
    shutil.copy(krb5_file, krb5destpath) 


p = run(['klist', '-kte'], stdout=PIPE)
if not f"{user}@{domain}" in str(p.stdout):
    print("Configuring krb5")
    input_load = f"""add_entry -password -p {user}@{domain} -k 1 -e aes256-cts
    {password}
    write_kt /etc/krb5.keytab
    quit
    """
    p = run(['ktutil'], stdout=PIPE, input=input_load, encoding='ascii')

print("Adding automatic mount point configuration")
mount_folders = ["T4", "T4b"]
folders = input("What folders would you like to mount? (separated by ;). Default is T4;T4b")
if folders:
    mount_folders = [s.strip() for s in folders.split(";")]

fstab_path =  Path("/etc/fstab")
with fstab_path.open("r") as fstab:
    content = fstab.read()
for f in mount_folders:
    if not f"//filer2-IMN.imn.u-bordeaux2.fr/{f}    " in  content:
        print(f"Adding mount information for {f} in /etc/fstab")
        mount_point = Path(f"/media/filer2/{f}")
        mount_point.mkdir(parents=True, exist_ok=True)
        
        p = run(['findmnt', mount_point], stdout=PIPE)
        if p.stdout:
            print(f"Mount point {mount_point} already has en entry. Please delete it by manually editing /etc/fstab if you want it processed. Ignoring it for this time")
        else:
            with Path("/etc/fstab").open("a") as fstab:
                fstab.write(f"//filer2-IMN.imn.u-bordeaux2.fr/{f}    {mount_point} cifs    users,credentials={credentials_file},iocharset=utf8,rw,sec=krb5i,file_mode=0777,dir_mode=0777    0    0\n")

print("Mounting")
run(['mount', "-a"])
