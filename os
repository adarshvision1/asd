EXP-4 FCFS:
n = int(input("No. of processes: "))
at = list(map(int, input("Arrival Times: ").split()))
bt = list(map(int, input("Burst Times: ").split()))
ct, tat, wt = [0]*n, [0]*n, [0]*n
time = 0
for i in range(n):
# Completion Time
time = max(time, at[i]) + bt[i]
ct[i] = time
# Turnaround Time = CT - AT
tat[i] = ct[i] - at[i]
# Waiting Time = TAT - BT
wt[i] = tat[i] - bt[i]
# Display result
for i in range(n):
print(f"Process {i+1}: AT={at[i]}, BT={bt[i]}, CT={ct[i]}, TAT={tat[i]}, WT={wt[i]}")
SJF:
n = int(input("No. of processes: "))
at = list(map(int, input("Arrival Times: ").split()))
bt = list(map(int, input("Burst Times: ").split()))
processes = [(i, at[i], bt[i]) for i in range(n)]
processes.sort(key=lambda x: (x[1], x[2])) # sort by arrival, then burst
ct, tat, wt = [0]*n, [0]*n, [0]*n
time = 0
for pid, arrival, burst in processes:
if time < arrival:
time = arrival
time += burst
ct[pid] = time
tat[pid] = ct[pid] - arrival
wt[pid] = tat[pid] - burst
for i in range(n):
print(f"Process {i+1}: AT={at[i]}, BT={bt[i]}, CT={ct[i]}, TAT={tat[i]}, WT={wt[i]}")
EXP-5
import threading, time
n = 5 # number of philosophers
forks = [threading.Lock() for
_
in range(n)]
def philosopher(i):
while True:
print(f"Philosopher {i} is thinking")
time.sleep(1)
left, right = forks[i], forks[(i+1) % n]
# pick forks
with left, right:
print(f"Philosopher {i} is eating 🍝
time.sleep(1)
")
for i in range(n):
threading.Thread(target=philosopher, args=(i,), daemon=True).start()
time.sleep(10) # run for 10 seconds
EXP-6
P = 5 # number of processes
R = 3 # number of resources
alloc = [
[0, 1, 0],
[2, 0, 0],
[3, 0, 2],
[2, 1, 1],
[0, 0, 2]
]
max
_
need = [
[7, 5, 3],
[3, 2, 2],
[9, 0, 2],
[2, 2, 2],
[4, 3, 3]
]
avail = [3, 3, 2]
# calculate need = max - alloc
need = [[max
_
need[i][j] - alloc[i][j] for j in range(R)] for i in range(P)]
finish = [0] * P
safe
_
seq = []
for
_
in range(P):
for i in range(P):
if finish[i] == 0:
if all(need[i][j] <= avail[j] for j in range(R)):
# can allocate
avail = [avail[j] + alloc[i][j] for j in range(R)]
safe
_
seq.append(i)
finish[i] = 1
if all(finish):
print("System is in a safe state.
")
print("Safe sequence:"
"
-> "
,
.join(f"P{p}" for p in safe
_
else:
seq))
print("System is NOT in a safe state.
")
EXP-7
First fit:
def first
_
fit():
a=[212,417,112,426]
b=[100,500,200,300,600]
for i in range (len(a)):
for j in range (len(b)):
if a[i]<b[j]:
print(a[i],
"
->"
,b[j])
b[j]=0
break
first
_
fit()
BEST FIT:
def best
_
fit():
a=[212,417,112,426]
b=[100,500,200,300,600]
b.sort();
for i in range (len(a)):
for j in range (len(b)):
if a[i]<b[j]:
print(a[i],
"
->"
,b[j])
b[j]=0
break
best
_
fit()
WORST FIT:
def worst
_
fit():
a=[212,417,112,426]
b=[100,500,200,300,600]
b.sort(reverse=True);
for i in range (len(a)):
for j in range (len(b)):
if a[i]<b[j]:
print(a[i],
"
->"
,b[j])
b[j]=0
break
worst
_
fit()
EXP-7.2:
PAGING:
def paging(total, size, pages):
print(f"\nTotal Pages: {total}, Page Size: {size} KB")
for p in pages:
print(f"Page {p} -> Frame {p}" if p < total else f"Page {p} -> Not in memory")
paging(8, 512, [0, 1, 4, 7, 9])
EXP-8:
# FIFO Page Replacement
def fifo(pages, frames):
memory = []
faults = 0
for p in pages:
if p not in memory: # Page fault
if len(memory) < frames:
memory.append(p)
else:
memory.pop(0) # remove oldest
memory.append(p)
faults += 1
print(f"Page {p} -> {memory}")
print("FIFO Page Faults:"
, faults,
"\n")
return faults
# LRU Page Replacement
def lru(pages, frames):
memory = []
faults = 0
for p in pages:
if p not in memory: # Page fault
if len(memory) < frames:
memory.append(p)
else:
# remove least recently used
memory.pop(0)
memory.append(p)
faults += 1
else:
# if page already in memory, move it to end (most recently used)
memory.remove(p)
memory.append(p)
print(f"Page {p} -> {memory}")
print("LRU Page Faults:"
, faults,
"\n")
return faults
# OPT (Optimal) Page Replacement (clean version)
def opt(pages, frames):
memory = []
faults = 0
for i in range(len(pages)):
p = pages[i]
if p not in memory: # Page fault
faults += 1
if len(memory) < frames:
memory.append(p)
else:
# find page not needed for the longest time in future
replace = max(
memory,
key=lambda x: pages[i+1:].index(x) if x in pages[i+1:] else float('inf')
)
memory.remove(replace)
memory.append(p)
print(f"Page {p} -> {memory}")
print("OPT Page Faults:"
, faults,
return faults
"\n")
# ---- MAIN ----
frames = int(input("Enter number of frames: "))
pages = list(map(int, input("Enter page reference string (space-separated): ").split()))
print("\n--- FIFO ---
")
fifo
_
faults = fifo(pages, frames)
print("
--- LRU ---
")
lru
_
faults = lru(pages, frames)
print("
--- OPT ---
")
opt
_
faults = opt(pages, frames)
print("=== Summary ===")
print(f"FIFO Faults: {fifo
_
faults}")
print(f"LRU Faults: {lru
_
faults}")
print(f"OPT Faults: {opt
_
faults}")
EXP-9
CONTIGIOUS MEMORY ALLOCATION:
disk
size = 20
_
disk = ["
.
"] * disk
_
size
def contiguous
_
allocate(file
_
name, size):
for i in range(size):
if disk[i:i+size] == ["
.
"] * size:
disk[i:i+size] = [file
_
name] * size
return f"{file
_
name} allocated from {i} to {i+size-1}"
return f"No space for {file
_
name}"
# Test
print("Initial Disk:"
""
,
.join(disk))
print(contiguous
_
allocate("A"
, 5))
print(contiguous
_
allocate("B"
, 7))
print("Final Disk: "
""
,
.join(disk))
LINKED MEMORY ALLOCATION:
import random
disk = ["
.
"]*20
def func(filename, size):
a = 0
while a < size: # simpler condition
num = random.randint(0, 19) if disk[num] == "
.
":
disk[num] = filename
a += 1
print(filename,
"
->"
, num)
# 0–19 only (not 20)
print("Initial:"
,
func("X"
, 4)
func("Y"
, 6)
print("Final:"
,
""
.join(disk))
""
.join(disk))
INDEXED ALLOCATION:
import random
disk = ["
.
"]*20
output=[]
def func(filename, size):
a = 0
output.append("{")
output.append(filename)
output.append(":")
num1=1
# print("{"
,filename,
" : ")
while a < size:
num = random.randint(0, 19)
if disk[num] == "
.
":
if(num1==1):
output.append("(")
output.append(str(num))
output.append("[")
num1=2;
#print("( "
,num,
" [ ")
else:
disk[num] = filename
a += 1
output.append(str(num))
output.append("
,
")
#print(num,
"
,
")
output.append(")")
output.append("]")
output.append("}")
#print(")]}")
print(""
.join(output))
print("Initial:"
,
func("X"
, 4)
func("Y"
, 6)
print("Final:"
,
""
.join(disk))
""
.join(disk))

def segment(table,ladd):
sno,o set=ladd
if sno>=len(table):
print("Invalid Segemnt Number")
return
base,limit=table[sno]#(2000=base , 150=limit)
if o set<limit:
phyadd=base+o set
print(" Physical Address ",phyadd)
else:
print("Segmentation Fault")
table=[(1000,100),(2000,150),(3000,170)]
l1=(1,120)
segment(table,l1)
l2=(2,180)
segment(table,l2)
