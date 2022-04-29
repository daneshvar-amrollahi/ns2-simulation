import sys

file = open(sys.argv[1], 'r')
lines = file.readlines()

sender_node = "_" + sys.argv[2] + "_"
receiver_node = "_" + sys.argv[3] + "_"

sent = dict()
packet_received=0;
packet_sent=0;

for line in lines[10:]:
    words = line.split()    

    current_node = words[2]
    packet_id = int(words[5])

    if packet_id == 0:
        continue

    if words[0] == "s" and words[2] == sender_node:
        sent[packet_id] = True
        packet_sent+=1

    if words[0] == "r" and packet_id in sent:
        packet_received+=1
        


print(f"packets sent from {sender_node} = {packet_sent}")
print(f"packets received from {receiver_node} = {packet_received}")
print(f"Transfer Ratio = {packet_received/packet_sent}")

# How 2 run: python transfer_ratio.py 1p5mbps/wireless.tr 0 7