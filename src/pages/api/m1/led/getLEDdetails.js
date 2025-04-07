'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getLEDdetails(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = `
      SELECT distinct
      bezeichnung_led_de as Bezeichnung_DE,
      bezeichnung_led_en as Bezeichnung_EN,
      artikelnummer_led as Artikelnummer,
      produktbeschreibung_led_de as Produktbeschreibung_DE,
      produktbeschreibung_led_en as Produktbeschreibung_EN,
      preis_led as Preis,
      seo_url_led_de as SEO_Url_DE,
      seo_url_led_en as SEO_Url_EN

      FROM m1
      WHERE 1=1


    `

    params.forEach(element => {
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

    query += ' ORDER BY 1'

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
