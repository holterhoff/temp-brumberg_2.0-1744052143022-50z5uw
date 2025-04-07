import query from '../dbservice'

export default async function getSteuerung(req, res) {
  if(req.method == 'POST'){

   let params = JSON.parse(req.body)
   let leuchte = ''
   params.forEach(element => {
        if(element.label == 'Leuchte'){

          leuchte = element.value

        }
    });

   let sql = "SELECT DISTINCT Steuerungsvariante as [value] FROM test WHERE Leuchtentyp LIKE ('%"+leuchte+"%')" ;
   const result = await query(sql)

  if (result) {
    res.status(200).json(result)
  }else {

    res.status(500).json({message:'Fehler beim Login'})

  }
 }else {

    res.status(401).json({message: 'This Methode not allowed'})

 }
}
