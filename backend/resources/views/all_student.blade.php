<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>

    <table>
        <thead>
            <th>id</th>
            <th>name</th>
            <th>fname</th>
        </thead>
        <tbody>
                @foreach ($allstudent as $key => $item) 
            <tr>


                    <td>{{$key +1 }}</td>
                    <td>{{$item->name}}</td>
                    <td>{{$item->fname}}</td>
            </tr>

                @endforeach
        </tbody>
    </table>
    
</body>
</html>