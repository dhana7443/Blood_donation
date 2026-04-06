CREATE TABLE raw.technician_tasks (
  technician_id  TEXT,  -- Identifier for the technician
  task_id        TEXT   -- Identifier for the task assigned to the technician
);

-- copy command to load data into the technician_tasks table
\copy raw.technician_tasks FROM 'C:\Users\Dhanalakshmi Karri\Downloads\technician_tasks.csv' WITH(FORMAT csv,HEADER,NULL '');
