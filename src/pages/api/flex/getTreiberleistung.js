import query from '../dbservice'

export default async function getreiberleistung(req, res) {
  if(req.method == 'POST'){

    let params = JSON.parse(req.body)
    let Treiber = ''
    let Steuerungstyp = ''

    params.forEach(element => {
          if(element.label == 'Treiber'){

            Treiber = element.value

          }
          if(element.label == 'Steuerungstyp'){

            Steuerungstyp = element.value

          }
      });

   let sql = "SELECT DISTINCT Treiber_Leistung as [value] FROM test WHERE CONCAT(Steuerungstyp, ' - ', Maximal_Leistung, ' Watt') LIKE ('%"+Steuerungstyp+"%') AND Treiber_Hersteller LIKE ('%"+Treiber+"%') order by 1 asc" ;

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
