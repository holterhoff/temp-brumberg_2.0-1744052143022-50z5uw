import query from '../dbservice'

export default async function getSteuerungstyp(req, res) {
if(req.method == 'POST'){

   let params = JSON.parse(req.body)
   let Steuerungsvariante = ''
   params.forEach(element => {
        if(element.label == 'Steuerungsvariante'){

          Steuerungsvariante = element.value

        }
    });


   let sql = "SELECT DISTINCT CONCAT(Steuerungstyp, ' - ', Maximal_Leistung, ' Watt') as [value] FROM test WHERE Steuerungsvariante LIKE ('%"+Steuerungsvariante+"%')" ;

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
