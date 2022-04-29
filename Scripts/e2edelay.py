import sys

file = open(sys.argv[1], 'r')
lines = file.readlines()

sender_node = "_" + sys.argv[2] + "_"
receiver_node = "_" + sys.argv[3] + "_"

sent = dict()
total_delay = 0
cnt = 0

for line in lines[10:]:
    words = line.split()    

    trace_level = words[3]
    payload_type = words[6]
    current_node = words[2]
    event_tpye = words[0]
    packet_id = int(words[5])
    time = float(words[1])

    if packet_id == 0:
        continue

    if words[0] == "s" and words[2] == sender_node:
        sent[(sender_node, packet_id, payload_type, trace_level)] = time

    if words[0] == "r" and (sender_node, packet_id, payload_type, trace_level) in sent:
        delay = time - sent[(sender_node, packet_id, payload_type, trace_level)]

        # print(sent[(sender_node, packet_id, payload_type, trace_level, packet_size)], time)

        total_delay += delay
        cnt += 1


print(f"Total Delay from {sender_node} to {receiver_node} = {total_delay}s")
print(f"Number of packets transferred from {sender_node} and {receiver_node} = {cnt}")
print(f"Average End-to-End Delay = {total_delay/cnt}s")

# How 2 run: python e2edelay.py 1p5mbps/wireless.tr 0 7