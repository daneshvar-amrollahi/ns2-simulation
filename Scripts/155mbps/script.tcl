#Step 1 initialize variables
#Step 2 - Create simulator object
#Step 3 - Create tracing and animation file
#Step 4 - Network Topology
#Step 5 - General Operations Director
#Step 6 - Create nodes
#Step 7 - Create channel
#Step 8 - Position nodes
#Step 9 - Mobility codes (if nodes are moving)
#Step 10 - TCP, UDP traffic
#run the simulation

set val(chan)           Channel/WirelessChannel    	;# Type of channel
set val(prop)           Propagation/TwoRayGround   	;# Radio model (propagation)
set val(netif)          Phy/WirelessPhy            	;# NIC (Interface Card)
set val(mac)            Mac/802_11                 	;# Medium Access Control (MAC)
set val(ifq)            Queue/DropTail/PriQueue    	;# Type of queuing interface
set val(ll)             LL                         	;# link layer type
set val(ant)            Antenna/OmniAntenna        	;# Antenna Model
set val(ifqlen)         50                         	;# max packet in interface queue
set val(nn)             9                          	;# number of mobilenodes
set val(rp)             AODV                       	;# routing protocol
set val(x)        		500							;# in meters
set val(y)        		500							;# in meters
set val(drate)			155e6			   			;# 155Mbps


#Creation of simulator
set ns [new Simulator]

#Creation of Trace and Namfile
set tracefile [open wireless.tr w]
$ns trace-all $tracefile

set namfile [open wireless.nam w]
$ns namtrace-all-wireless $namfile $val(x) $val(y)

#Network Topology
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

#GOD
create-god $val(nn)

#Set bandwith
$val(mac) set dataRate_ $val(drate)


set channel1 [new $val(chan)]
# set channel2 [new $val(chan)]

#Configure the node
$ns node-config -adhocRouting $val(rp) \
			 	-llType $val(ll) \
			 	-macType $val(mac) \
			 	-ifqType $val(ifq) \
			 	-ifqLen $val(ifqlen) \
			 	-antType $val(ant) \
			 	-propType $val(prop) \
			 	-phyType $val(netif) \
			 	-topoInstance $topo \
			 	-agentTrace ON \
			 	-macTrace ON \
			 	-routerTrace ON \
			 	-movementTrace ON \
			 	-channel $channel1

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# $ns node-config -channel $channel2
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]

$n0 random-motion 0
$n1 random-motion 0
$n2 random-motion 0
$n3 random-motion 0
$n4 random-motion 0
$n5 random-motion 0

# Size of the nodes
$ns initial_node_pos $n0 20
$ns initial_node_pos $n1 20
$ns initial_node_pos $n2 20
$ns initial_node_pos $n3 20
$ns initial_node_pos $n4 20
$ns initial_node_pos $n5 20
$ns initial_node_pos $n6 20
$ns initial_node_pos $n7 20
$ns initial_node_pos $n8 20

#initial coordinates of the nodes
$n0 set X_ 50.0
$n0 set Y_ 330.0
$n0 set Z_ 0.0

$n1 set X_ 0.0
$n1 set Y_ 230.0
$n1 set Z_ 0.0

$n2 set X_ 50.0
$n2 set Y_ 130.0
$n2 set Z_ 0.0

$n3 set X_ 100.0
$n3 set Y_ 180.0
$n3 set Z_ 0.0

$n4 set X_ 100.0
$n4 set Y_ 280.0
$n4 set Z_ 0.0

$n5 set X_ 150.0
$n5 set Y_ 280.0
$n5 set Z_ 0.0

$n6 set X_ 150.0
$n6 set Y_ 180.0
$n6 set Z_ 0.0

$n7 set X_ 200.0
$n7 set Y_ 280.0
$n7 set Z_ 0.0

$n8 set X_ 200.0
$n8 set Y_ 180.0
$n8 set Z_ 0.0

#mobility of the nodes
#At what time? Which node? Where to? What speed?	
$ns at 0.0 "$n0 setdest 490.0 340.0 0.0"
$ns at 0.0 "$n1 setdest 490.0 340.0 0.0"
$ns at 0.0 "$n2 setdest 490.0 340.0 0.0"
$ns at 0.0 "$n3 setdest 490.0 340.0 0.0"
$ns at 0.0 "$n4 setdest 300.0 130.0 0.0"
$ns at 0.0 "$n5 setdest 190.0 440.0 0.0"
$ns at 0.0 "$n6 setdest 490.0 340.0 0.0"
$ns at 0.0 "$n7 setdest 300.0 130.0 0.0"
$ns at 0.0 "$n8 setdest 190.0 440.0 0.0"


#Creation of agents
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $n0 $tcp
$ns attach-agent $n7 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"

set udp [new Agent/UDP]
set null [new Agent/Null]
$ns attach-agent $n2 $udp
$ns attach-agent $n8 $null
$ns connect $udp $null
set  cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$ns at 1.0 "$cbr start"

$ns at 101.0 "finish"

proc finish {} {
	global ns tracefile namfile
	$ns flush-trace
	close $tracefile
	close $namfile

	exec nam wireless.nam &
	exit 0
}

puts "Starting simulation"
$ns run 

