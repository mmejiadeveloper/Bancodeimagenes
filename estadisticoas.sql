cuantas descxrgas tiene el recurso
SELECT p.postId, COUNT(pup.`postsUserProjectsId`) FROM posts AS p
LEFT JOIN posts_user_projects AS pup
ON pup.`postId` = p.`postId`
WHERE p.postId = 33
GROUP BY p.`postId`

cuantos favoritos tiene la foto
SELECT p.postId, COUNT(pup.postFavoriteId) FROM posts AS p
LEFT JOIN posts_favorites AS pup
ON pup.`postId` = p.`postId`
WHERE p.postId = 32
GROUP BY p.`postId`

en cuantos proyectos esta el recurso
SELECT p.postId, COUNT(up.usersProjectId) FROM posts AS p
LEFT JOIN posts_user_projects AS pup
ON pup.`postId` = p.`postId`
LEFT JOIN users_projects AS up
ON up.usersProjectId = pup.`projectId`
WHERE p.postId = 33
GROUP BY p.`postId`

cuantos usuarios han descargado
SELECT u.userId FROM users u
LEFT JOIN users_projects AS up
ON up.userId = u.`userId`
LEFT JOIN posts_user_projects AS pup
ON pup.projectId = up.usersProjectId
WHERE pup.postId = 33
GROUP BY u.userId

