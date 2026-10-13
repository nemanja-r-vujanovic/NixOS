import os
import subprocess

def run_command(command):
	result = subprocess.run(command, shell=True, capture_output=True, text=True)
	return result.stdout

sandbox_running = run_command("firejail --ls=sandbox $HOME/Downloads/")
counter = 0

if (sandbox_running.strip()):
	os.chdir(os.path.expanduser("$HOME/Downloads/RestoredSandbox/"))
	files_output = run_command("firejail --ls=sandbox $HOME/Downloads/")

	files = []
	for line in files_output.splitlines()[2:]:
		parts = line.split(maxsplit = 4)
		if (len(parts) >= 5):
			files.append(parts[4])

	for file in files:
		print(f"Processing: {file}...")
		run_command(f"firejail --get=sandbox $HOME/Downloads/\"{file}\"")
		counter += 1

else:
	print("Sandbox is not running!")
	exit()

if (counter == 0):
	print("Sandbox is empty!")