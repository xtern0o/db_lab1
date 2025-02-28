WITH biggest_swarm AS (
    SELECT swarm.id FROM swarm
    JOIN dinosaur ON swarm.id = dinosaur.current_swarm_id
    GROUP BY swarm.id
    ORDER BY COUNT(dinosaur.id) DESC
    LIMIT 1
)

SELECT COUNT(dinosaur.id) AS gogo_count FROM dinosaur
JOIN biggest_swarm ON dinosaur.current_swarm_id = biggest_swarm.id
JOIN dino_to_action ON dinosaur.id = dino_to_action.dino_id
JOIN action ON dino_to_action.action_id = action.id
WHERE action.name = 'гоготать';
