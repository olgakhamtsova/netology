/*
        Ќаписать запрос, который выводит общее число тегов
*/
printjson(
	db.tags.find().count());

/*
        ƒобавл€ем фильтрацию: считаем только количество тегов woman
*/
printjson
(db.tags.find({name: {$gt: 'woman'}}).count());
/*


        ќчень сложный запрос: используем группировку данных посчитать количество вхождений дл€ каждого тега
        и напечатать top-3 самых попул€рных
*/

printjson(
	db.tags.aggregate([
		{$group: {
			_id: "$name", 
			tag_count: { $sum: 1 }}
			},
				{$sort:{tag_count: -1}}, 
				{$limit: 3 }
	])['_batch']
);
