EXP-2
1. Read and Display User Input:
# Read and display user input
name = input("Enter your name: ")
print(f"Hello, {name}!")
2. Find the Largest of Three Numbers:
a, b, c = map(int, input("Enter 3 numbers separated by space: ").split())
largest = a
if b > largest:
largest = b
if c > largest:
largest = c
print(f"The largest of {a}, {b}, {c} is {largest}")
3. Check if Number is Even or Odd:
n = int(input("Enter a number: "))
if n % 2 == 0:
print(f"{n} is Even")
else:
print(f"{n} is Odd")
4. Looping Example – Print 1 to 5:
# Print numbers 1 to 5
for i in range(1, 6):
print(f"Number: {i}")
5. Fibonacci Series :
# Fibonacci series up to n terms
n = int(input("Enter number of terms: "))
a, b = 0, 1
print("Fibonacci Series:"
, end=" ")
for
_
in range(n):
print(a, end=" ")
a, b = b, a + b
6. Multiplication Table :
# Multiplication table of a number
num = int(input("Enter a number: "))
print(f"Multiplication table of {num}:")
for i in range(1, 11):
print(f"{num} x {i} = {num * i}")
7. Swapping of Two Numbers :
# Swapping two numbers
a, b = map(int, input("Enter two numbers separated by space: ").split())
print(f"Before swap: a = {a}, b = {b}")
a, b = b, a # Pythonic swap
print(f"After swap: a = {a}, b = {b}")
EXP-3
# ---------------- Program 1: fork() ----------------
import os
pid = os.fork()
if pid == 0:
print("Child process")
else:
print("Parent process")
# ---------------- Program 2: exec() ----------------
import os
os.execl("/bin/ls"
,
"ls"
,
"
-l")
# ---------------- Program 3: wait() ----------------
import os
pid = os.fork()
if pid == 0:
print("Child running")
os.
_
exit(0)
else:
os.wait()
print("Parent after child")
# ---------------- Program 4: File I/O ----------------
import os
fd = os.open("test.txt"
, os.O
_
CREAT | os.O
_
WRONLY, 0o644)
os.write(fd, b"Hello, OS!")
os.close(fd)
print("Data written to test.txt")
EXP-4
# FCFS Scheduling
n = int(input("Enter no. of processes: "))
at = list(map(int, input("Arrival Times: ").split()))
bt = list(map(int, input("Burst Times: ").split()))
ct, tat, wt, st = [0]*n, [0]*n, [0]*n, 0
for i in range(n):
st = max(st, at[i])
ct[i] = st + bt[i]
tat[i] = ct[i] - at[i]
wt[i] = tat[i] - bt[i]
st = ct[i]
print("P\tAT\tBT\tCT\tTAT\tWT")
for i in range(n):
print(f"P{i+1}\t{at[i]}\t{bt[i]}\t{ct[i]}\t{tat[i]}\t{wt[i]}")
# SJF (Non-preemptive)
n = int(input("Enter no. of processes: "))
at = list(map(int, input("Arrival Times: ").split()))
bt = list(map(int, input("Burst Times: ").split()))
done, t, ct, tat, wt = [0]*n, 0, [0]*n, [0]*n, [0]*n
for
_
in range(n):
idx = -1
for i in range(n):
if not done[i] and at[i] <= t:
if idx == -1 or bt[i] < bt[idx]: idx = i
if idx == -1: t += 1; continue
t += bt[idx]; ct[idx] = t
tat[idx] = ct[idx] - at[idx]; wt[idx] = tat[idx] - bt[idx]
done[idx] = 1
print("P\tAT\tBT\tCT\tTAT\tWT")
for i in range(n):
print(f"P{i+1}\t{at[i]}\t{bt[i]}\t{ct[i]}\t{tat[i]}\t{wt[i]}")
# SRTF (Preemptive SJF)
n = int(input("Enter no. of processes: "))
at = list(map(int, input("Arrival Times: ").split()))
bt = list(map(int, input("Burst Times: ").split()))
rt, t, done, ct, tat, wt = bt[:], 0, 0, [0]*n, [0]*n, [0]*n
while done < n:
idx = -1
for i in range(n):
if at[i] <= t and rt[i] > 0:
if idx == -1 or rt[i] < rt[idx]: idx = i
if idx == -1: t += 1; continue
rt[idx] -= 1; t += 1
if rt[idx] == 0:
ct[idx] = t; tat[idx] = ct[idx] - at[idx]; wt[idx] = tat[idx] - bt[idx]; done += 1
print("P\tAT\tBT\tCT\tTAT\tWT")
for i in range(n):
print(f"P{i+1}\t{at[i]}\t{bt[i]}\t{ct[i]}\t{tat[i]}\t{wt[i]}")
# Round Robin
n = int(input("Enter no. of processes: "))
at = list(map(int, input("Arrival Times: ").split()))
bt = list(map(int, input("Burst Times: ").split()))
q = int(input("Time Quantum: "))
rt, t, done, ct, tat, wt = bt[:], 0, 0, [0]*n, [0]*n, [0]*n
while done < n:
idle = True
for i in range(n):
if at[i] <= t and rt[i] > 0:
idle = False
if rt[i] > q: t += q; rt[i] -= q
else: t += rt[i]; ct[i] = t; tat[i] = ct[i]-at[i]; wt[i]=tat[i]-bt[i]; rt[i]=0; done+=1
if idle: t += 1
print("P\tAT\tBT\tCT\tTAT\tWT")
for i in range(n):
print(f"P{i+1}\t{at[i]}\t{bt[i]}\t{ct[i]}\t{tat[i]}\t{wt[i]}")
# Priority Scheduling (Non-preemptive)
n = int(input("Enter no. of processes: "))
at = list(map(int, input("Arrival Times: ").split()))
bt = list(map(int, input("Burst Times: ").split()))
pr = list(map(int, input("Priorities (smaller=high): ").split()))
done, t, ct, tat, wt = [0]*n, 0, [0]*n, [0]*n, [0]*n
for
_
in range(n):
idx = -1
for i in range(n):
if not done[i] and at[i] <= t:
if idx == -1 or pr[i] < pr[idx]: idx = i
if idx == -1: t += 1; continue
t += bt[idx]; ct[idx] = t
tat[idx] = ct[idx] - at[idx]; wt[idx] = tat[idx] - bt[idx]; done[idx]=1
print("P\tAT\tBT\tPR\tCT\tTAT\tWT")
for i in range(n):
print(f"P{i+1}\t{at[i]}\t{bt[i]}\t{pr[i]}\t{ct[i]}\t{tat[i]}\t{wt[i]}")
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
left, right = forks[i], forks[(i+1)%n]
# pick forks
with left, right:
print(f"Philosopher {i} is eating 🍝
time.sleep(1)
for i in range(n):
")
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
print("System is NOT in a safe state.
")
seq))
EXP-7
MEMORY ALLOCATION:
def first
_
fit(blocks, processes):
alloc = [-1]*len(processes)
used = [False]*len(blocks)
for i, p in enumerate(processes):
for j, b in enumerate(blocks):
if not used[j] and b >= p:
alloc[i], used[j] = j, True
break
print("\nFirst Fit:")
for i, a in enumerate(alloc):
print(f"P{i+1} (size {processes[i]}) ->"
, f"Block {a+1}" if a!=-1 else "Not Allocated")
def best
_
fit(blocks, processes):
alloc = [-1]*len(processes)
used = [False]*len(blocks)
for i, p in enumerate(processes):
best = -1
for j, b in enumerate(blocks):
if not used[j] and b >= p and (best==-1 or b<blocks[best]):
best = j
if best != -1:
alloc[i], used[best] = best, True
print("\nBest Fit:")
for i, a in enumerate(alloc):
print(f"P{i+1} (size {processes[i]}) ->"
, f"Block {a+1}" if a!=-1 else "Not Allocated")
def worst
_
fit(blocks, processes):
alloc = [-1]*len(processes)
used = [False]*len(blocks)
for i, p in enumerate(processes):
worst = -1
for j, b in enumerate(blocks):
if not used[j] and b >= p and (worst==-1 or b>blocks[worst]):
worst = j
if worst != -1:
alloc[i], used[worst] = worst, True
print("\nWorst Fit:")
for i, a in enumerate(alloc):
print(f"P{i+1} (size {processes[i]}) ->"
, f"Block {a+1}" if a!=-1 else "Not Allocated")
# Main
blocks = [100, 500, 200, 300, 600]
processes = [212, 417, 112, 426]
print("Blocks:"
, blocks)
print("Processes:"
, processes)
first
_
fit(blocks[:], processes)
best
_
fit(blocks[:], processes)
worst
_
fit(blocks[:], processes)
PAGING:
def simulate
_paging(total
_pages, page
_
size, process
_pages):
print(f"\nTotal Pages: {total
_pages}, Page Size: {page
_
size} KB")
print("Process Pages Loaded in Frames:")
for page in process
_pages:
if page < total
_pages:
print(f"Page {page} -> Frame {page}")
else:
print(f"Page {page} -> Not in memory")
# Example usage
if
name
== "
main
":
__
__
__
__
total
_pages = 8
page
_
size = 512 # Example page size in KB
process
_pages = [0, 1, 4, 7, 9] # Pages the process wants to access
simulate
_paging(total
_pages, page
_
size, process
_pages)
EXP-8
# FIFO Page Replacement
def fifo(pages, frames):
memory, faults = [], 0
for p in pages:
if p not in memory:
if len(memory) < frames:
memory.append(p)
else:
memory.pop(0) # remove first in
memory.append(p)
faults += 1
print(f"Page {p}: {memory}")
print("FIFO Faults:"
, faults,
"\n")
# LRU Page Replacement
def lru(pages, frames):
memory, faults = [], 0
for i, p in enumerate(pages):
if p not in memory:
if len(memory) < frames:
memory.append(p)
else:
# least recently used → farthest back in history
lru
_page = min(memory, key=lambda x: (i - max(j for j in range(i) if pages[j] == x)))
memory[memory.index(lru
_page)] = p
faults += 1
print(f"Page {p}: {memory}")
print("LRU Faults:"
, faults,
"\n")
# OPT Page Replacement
def opt(pages, frames):
memory, faults = [], 0
for i, p in enumerate(pages):
if p not in memory:
if len(memory) < frames:
memory.append(p)
else:
future = []
for m in memory:
if m in pages[i+1:]:
future.append(pages[i+1:].index(m))
else:
future.append(float("inf")) # never used again
memory[future.index(max(future))] = p
faults += 1
print(f"Page {p}: {memory}")
print("OPT Faults:"
, faults,
"\n")
# ---- MAIN ----
frames = int(input("Enter number of frames: "))
pages = list(map(int, input("Enter page reference string (space-separated): ").split()))
print("\n--- FIFO ---
")
fifo(pages, frames)
print("
--- LRU ---
")
lru(pages, frames)
print("
--- OPT ---
")
opt(pages, frames)
EXP-10
1.CONTIGIOUS:
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
global disk
for start in range(disk
_
size - size + 1):
if all(disk[i] == "
.
" for i in range(start, start + size)):
for i in range(start, start + size):
disk[i] = file
name
_
return f"{file
_
name} allocated from block {start} to {start + size - 1}"
return f"No space for {file
_
name}"
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
2.NON-CONTIGIOUS:
disk
size = 20
_
disk = ["
.
"] * disk
size
_
free
_
blocks = list(range(disk
_
file
_
table = {}
import random
size))
def linked
_
allocate(file
_
name, size):
global free
blocks
_
if len(free
_
blocks) < size:
return f"No space for {file
_
name}"
allocated = random.sample(free
_
blocks, size) # RANDOM
for b in allocated:
disk[b] = file
name
_
free
_
blocks.remove(b)
file
_
table[file
_
name] = allocated
return f"{file
_
name} allocated at blocks {allocated}"
print("Initial Disk:"
""
,
.join(disk))
print(linked
_
allocate("X"
, 4))
print(linked
_
allocate("Y"
, 6))
print("Final Disk: "
""
,
.join(disk))
print("File Table: "
, file
_
table)
3. INDEXED :
disk
size = 20
_
disk = ["
.
"] * disk
size
_
free
_
blocks = list(range(disk
_
file
_
table = {}
import random
size))
def indexed
_
allocate(file
_
name, size):
global free
blocks
_
if len(free
_
blocks) < size + 1:
return f"No space for {file
_
name}"
index
_
block = random.choice(free
_
blocks) # One block as index
free
_
blocks.remove(index
_
block)
disk[index
_
block] = "#"
data
_
blocks = random.sample(free
_
blocks, size)
for b in data
blocks:
_
disk[b] = file
name
_
free
_
blocks.remove(b)
file
_
table[file
_
name] = (index
block, data
_
_
blocks)
return f"{file
_
name} allocated with index {index
_
block}, data blocks {data
_
blocks}"
print("Initial Disk:"
""
,
.join(disk))
print(indexed
_
allocate("P"
, 4))
print(indexed
_
allocate("Q"
, 3))
print("Final Disk: "
""
,
.join(disk))
print("File Table: "
, file
_
table)
