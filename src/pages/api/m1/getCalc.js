'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getCalc(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)
    let anzahl = params.find(element => element.label == 'Anzahl')
    let query = `
     SELECT
     ${anzahl.value} as anzahl,
     "id",
      leuchtentyp,
      typ_gehaeuse_de,
      typ_gehaeuse_en,
      bezeichnung_de,
      bezeichnung_en,
      typ_de,
      typ_en,
      form_de,
      form_en,
      farbe_de,
      farbe_en,
      verstellbarkeit_de,
      verstellbarkeit_en,
      schutzart,
      einbaudurchmesser,
      schwenkwinkel,
      anzahl_leuchtmittel,
      produktbeschreibung_gehaeuse_de,
      produktbeschreibung_gehaeuse_en,
      artikelnummer_gehaeuse,
      bezeichnung_gehaeuse_de,
      bezeichnung_gehaeuse_en,
      datenblatt_gehaeuse_de,
      datenblatt_gehaeuse_en,
      REPLACE(preis_gehaeuse,',','.') as preis_gehaeuse,
      gehaeuse_image,
      seo_url_gehaeuse_de,
      seo_url_gehaeuse_en,
      typ_led, lichtfarbe,
      farbkanal,
      lichtstrom,
      leistung,
      abstrahlwinkel,
      artikelnummer_led,
      REPLACE(preis_led,',','.') as preis_led,
      leuchten_image,
      produktbeschreibung_led_de,
      produktbeschreibung_led_en,
      seo_url_led_de,
      seo_url_led_en,
      datenblatt_led_de,
      datenblatt_led_en,
      bezeichnung_led_de,
      bezeichnung_led_en,
      treiber_de,
      treiber_en,
      beschreibung,
      versorgung,
      ansteuerung_de,
      ansteuerung_en,
      ansteuerung2_de,
      ansteuerung2_en,
      ausfuehrung_de,
      ausfuehrung_en,
      bezeichnung_treiber_de,
      bezeichnung_treiber_en,
      treiber_image,
      produktbeschreibung_treiber_de,
      produktbeschreibung_treiber_en,
      typ_treiber,
      leistung_min,
      leistung_max,
      artikelnummer_treiber,
      REPLACE(preis_treiber,',','.') as preis_treiber,
      seo_url_treiber_de,
      seo_url_treiber_en,
      datenblatt_treiber_de,
      datenblatt_treiber_en,
      min_anzahl,
      max_anzahl


    FROM m1
        WHERE 1=1


    `

    params.forEach(element => {
      //Gehäuse
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
      //Treiber
      if (element.label == 'Treiber') {
        let treiber = element.value
        query += " AND (treiber_de = '" + treiber + "' OR treiber_en = '" + treiber + "')"
      }

      if (element.label == 'Ansteuerung') {
        let ansteuerung = element.value
        query += " AND (ansteuerung2_de = '" + ansteuerung + "' OR ansteuerung2_en = '" + ansteuerung + "')"
      }

      if (element.label == 'Anschlussleitung') {
        let ausfuehrung = element.value
        query += " AND (ausfuehrung_de = '" + ausfuehrung + "' OR ausfuehrung_en = '" + ausfuehrung + "')"
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
