import query from '../dbservice'

export default async function getLichtfarbe(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let sql = 'SELECT DISTINCT Lichtfarbe as [value] FROM [Brumberg].[fakt].[birocircle]  WHERE 1=1 '

    params.forEach(element => {
      if (element.label == 'Leuchtentyp') {
        let leuchtentyp = element.value
        sql += " AND Leuchtentyp LIKE '%" + leuchtentyp + "%'"
      }

      if (element.label == 'Durchmesser') {
        let druchmesser = element.value
        sql += " AND Durchmesser = '" + druchmesser + "'"
      }

      // if (element.label == 'Farbkanal') {
      //   let farbkanal = element.value
      //   sql += " AND Farbkanal LIKE '%" + farbkanal + "%'"
      // }

      // if (element.label == 'Lichtfarbe') {
      //   let lichtfarbe = element.value
      //   sql += " AND Lichtfarbe LIKE '%" + lichtfarbe + "%'"
      // }

      // if (element.label == 'Leistung') {
      //   let leistung = element.value
      //   sql += " AND Leistung LIKE '%" + leistung + "%'"
      // }
    })

    const result = await query(sql)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
