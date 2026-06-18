import re
import subprocess

def is_valid_ip(ip):
    # Regular expression to validate an IP address
    pattern = re.compile(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$")
    if pattern.match(ip):
        # Check if each octet is between 0 and 255
        parts = ip.split(".")
        for part in parts:
            if int(part) < 0 or int(part) > 255:
                return False
        return True
    return False

def check_connectivity(ip):
    try:
        # Ping the IP address to check connectivity
        result = subprocess.run(["ping", "-c", "1", ip], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return result.returncode == 0
    except Exception as e:
        return False

def main():
    with open("ip_input.txt", "r") as file:
        ips = file.readlines()

    for ip in ips:
        ip = ip.strip()
        if is_valid_ip(ip):
            print(f"{ip} is a valid IP address.")
            if check_connectivity(ip):
                print(f"{ip} is reachable.")
            else:
                print(f"{ip} is not reachable.")
        else:
            print(f"{ip} is not a valid IP address.")

if __name__ == "__main__":
    main()
