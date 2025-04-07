'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getImageGehaeuse(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = 'SELECT DISTINCT gehaeuse_image as value FROM m1 WHERE 1=1  '

    params.forEach(element => {
      if (element.label == 'Form') {
        let form = element.value
        query += " AND (form_de = '" + form + "' OR form_en = '" + form + "')"
      }
      if (element.label == 'Leuchtentyp') {
        let typ = element.value
        query += " AND (typ_de = '" + typ + "' OR typ_en = '" + typ + "')"
      }
      if (element.label == 'Anzahl Leuchtmittel') {
        let anzahl_leuchtmittel = element.value
        query +=
          " AND (anzahl_leuchtmittel = '" +
          anzahl_leuchtmittel +
          "' OR anzahl_leuchtmittel = '" +
          anzahl_leuchtmittel +
          "')"
      }
      if (element.label == 'Farbe') {
        let farbe = element.value
        query += " AND (farbe_de = '" + farbe + "' OR farbe_en = '" + farbe + "')"
      }
      if (element.label == 'Verstellbarkeit') {
        let verstellbarkeit = element.value
        query +=
          " AND (verstellbarkeit_de = '" + verstellbarkeit + "' OR verstellbarkeit_en = '" + verstellbarkeit + "')"
      }
    })

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
