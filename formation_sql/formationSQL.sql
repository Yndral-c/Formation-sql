use spa;
select chat.id, chat.nom, chat.age, couleur.nom as "yeux"
from chat
left join couleur on chat.couleur_id = couleur.id where chat.couleur_id is null;

select * from chat where couleur_id is null