import pandas as pd
import random

NUM_TECHNICIANS = 1000   # from dim_technicians
NUM_TASKS = 50           # from dim_tasks

data = []
pairs = set()

for tech_id in range(1, NUM_TECHNICIANS + 1):

    # Each technician gets 2–5 tasks
    num_tasks = random.randint(2, 5)

    assigned_tasks = random.sample(range(1, NUM_TASKS + 1), num_tasks)

    for task_id in assigned_tasks:

        pair = (tech_id, task_id)

        # Avoid duplicates
        if pair not in pairs:
            pairs.add(pair)

            data.append({
                "technician_id": tech_id,
                "task_id": task_id
            })

df = pd.DataFrame(data)

df.to_csv("technician_tasks.csv", index=False)

print("CSV generated: technician_tasks.csv")