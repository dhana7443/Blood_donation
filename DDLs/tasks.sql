CREATE TABLE raw.tasks (
  task_id     TEXT,  -- Unique identifier for each task
  description TEXT   -- Detailed description of the task
);

-- copy command to load data into the tasks table
\copy raw.tasks FROM 'C:\Users\Dhanalakshmi Karri\Downloads\tasks.csv' WITH(FORMAT csv,HEADER,NULL '');