/*
        �������� ������, ������� ������� ����� ����� �����
*/
printjson(
	db.tags.find().count());

/*
        ��������� ����������: ������� ������ ���������� ����� woman
*/
printjson
(db.tags.find({name: {$gt: 'woman'}}).count());
/*


        ����� ������� ������: ���������� ����������� ������ ��������� ���������� ��������� ��� ������� ����
        � ���������� top-3 ����� ����������
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
