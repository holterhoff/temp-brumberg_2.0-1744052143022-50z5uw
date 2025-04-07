import query from '../dbservice'

export default async function getTreiber(req, res) {
  if(req.method == 'POST'){

    let params = JSON.parse(req.body)
    let Steuerungstyp = ''
    params.forEach(element => {
          if(element.label == 'Steuerungstyp'){

            Steuerungstyp = element.value

          }
      });

   let sql = "SELECT DISTINCT Treiber_Hersteller as [value] FROM test WHERE CONCAT(Steuerungstyp, ' - ', Maximal_Leistung, ' Watt') LIKE ('%"+Steuerungstyp+"%')" ;

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
