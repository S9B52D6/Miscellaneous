<?php
	$conn = mysqli_connect('localhost', 'root', 'crossfire', 'Other');
   	$result = mysqli_query($conn, "select * from cities;");
   	$data = array();
   	$i = 0;
   	while($row = mysqli_fetch_array($result))
   	{
   	   $data[$row['country']] = array('Capital' => $row['capital'], 'Population' => $row['population']);
	}
	file_put_contents('cities.json', json_encode($data, JSON_PRETTY_PRINT));
?>
