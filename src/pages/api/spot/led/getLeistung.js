'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getLeistung(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = 'SELECT DISTINCT leistung as value_de, leistung as value_en FROM spot WHERE 1=1 '

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
      if (element.label == 'Ausführung') {
        let farbkanal = element.value
        query += " AND (farbkanal = '" + farbkanal + "' OR farbkanal = '" + farbkanal + "')"
      }

      if (element.label == 'Lichtfarbe') {
        let lichtfarbe = element.value
        query += " AND (lichtfarbe = '" + lichtfarbe + "' OR lichtfarbe = '" + lichtfarbe + "')"
      }
    })

    query += 'ORDER BY 1 '

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
