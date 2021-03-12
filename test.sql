--to run this file from command line type: $psql kiddo_development -f test.sql

-- select * from users;
-- select * from missions;
-- select * from tasks;
-- select * from mission_tasks;

SELECT  tasks.category, count(tasks.id), sum(tasks.points) FROM "tasks" 
INNER JOIN "mission_tasks" ON "tasks"."id" = "mission_tasks"."task_id" 
INNER JOIN "missions" ON "mission_tasks"."mission_id" = "missions"."id" 
WHERE "missions"."user_id" = 10 
GROUP BY "tasks"."category";

SELECT  tasks.category, count(tasks.id), sum(tasks.points) FROM "tasks" 
INNER JOIN "mission_tasks" ON "tasks"."id" = "mission_tasks"."task_id" 
INNER JOIN "missions" ON "mission_tasks"."mission_id" = "missions"."id" 
WHERE "missions"."user_id" = 10 AND (mission_tasks.is_completed = TRUE) 
GROUP BY "tasks"."category";

SELECT  tasks.category, sum(tasks.points) AS sum_points FROM "tasks" GROUP BY "tasks"."category"

