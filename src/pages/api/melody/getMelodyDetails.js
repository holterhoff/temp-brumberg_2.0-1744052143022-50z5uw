import query from '../dbservice'

export default async function getMelodyDetails(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let sql =
      'SELECT DISTINCT Bezeichnung , Artikelnummer,Produktbeschreibung, Preis,  Website FROM [Brumberg].[fakt].[melody]  WHERE 1=1 '

    params.forEach(element => {
      if (element.label == 'Leuchtentyp') {
        let leuchtentyp = element.value
        sql += " AND Leuchtentyp = '" + leuchtentyp + "'"
      }

      if (element.label == 'Gehäusefarbe') {
        let farbe = element.value
        sql += " AND Gehaeusefarbe = '" + farbe + "'"
      }

      if (element.label == 'Lichtfarbe') {
        let lichtfarbe = element.value
        sql += " AND Lichtfarbe = '" + lichtfarbe + "'"
      }
      if (element.label == 'Schaltungsart') {
        let schaltungsart = element.value
        sql += " AND Schaltungsart = '" + schaltungsart + "'"
      }
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
