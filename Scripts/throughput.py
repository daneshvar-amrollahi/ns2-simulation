import sys

file = open(sys.argv[1], 'r')
lines = file.readlines()

total_time = int(float(lines[-1].split()[1]))
receiver_node = "_" + sys.argv[2] + "_"

data = 0
for line in lines:
    words = line.split()    
    if words[0] == "r" and words[2] == receiver_node:
        data += int(words[7])

print(f"Total Data Received by Node {receiver_node} = {data}")
print(f"Total Time = {total_time}")

print(f"Throughput = {data/total_time} bits/sec")

# How 2 run: python throughput.py 1p5mbps/wireless.tr 7