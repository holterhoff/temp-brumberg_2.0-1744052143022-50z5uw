'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getAnsteuerung(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = 'SELECT DISTINCT ansteuerung2_de as value_de, ansteuerung2_en as value_en  FROM spot WHERE 1=1'

    params.forEach(element => {
      if (element.label == 'Form') {
        let form = element.value
        query += " AND (form_de = '" + form + "' OR form_en = '" + form + "')"
      }
      if (element.label == 'Einbautiefe') {
        let einbautiefe = element.value
        query += " AND einbautiefe = '" + einbautiefe + "'"
      }
      if (element.label == 'Typ') {
        let typ = element.value
        query += " AND (typ_gehaeuse_de = '" + typ + "' OR typ_gehaeuse_en = '" + typ + "')"
      }
      if (element.label == 'Gehäusefarbe') {
        let gehaeusefarbe = element.value
        query += " AND (farbe_de = '" + gehaeusefarbe + "' OR farbe_en = '" + gehaeusefarbe + "')"
      }

      //LED

      if (element.label == 'Ausführung') {
        let farbkanal = element.value
        query += " AND (farbkanal = '" + farbkanal + "' OR farbkanal = '" + farbkanal + "')"
      }

      if (element.label == 'Lichtfarbe') {
        let lichtfarbe = element.value
        query += " AND (lichtfarbe = '" + lichtfarbe + "' OR lichtfarbe = '" + lichtfarbe + "')"
      }
      if (element.label == 'Leistung') {
        let leistung = element.value
        query += " AND (leistung = '" + leistung + "' OR leistung = '" + leistung + "')"
      }
      if (element.label == 'Abstrahlwinkel') {
        let abstrahlwinkel = element.value
        query += " AND (abstrahlwinkel = '" + abstrahlwinkel + "' OR abstrahlwinkel = '" + abstrahlwinkel + "')"
      }
    })

    query += '  ORDER BY 1'

    const result = await sql(query)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
