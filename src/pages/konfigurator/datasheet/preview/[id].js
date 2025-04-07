// ** Third Party Imports
import axios from 'axios'
import query from 'src/pages/api/dbservice'

// ** Demo Components Imports
import Preview from 'src/views/konfigurator/datasheet/preview/Preview'

const InvoicePreview = ({ id }) => {
  return <Preview id={id} />
}

export const getStaticPaths = async () => {
  let sql = 'SELECT DISTINCT top 10 ID FROM fakt.spot WHERE 1=1 '
  const result = await query(sql)
  let data = result

  const paths = data.map(item => ({
    params: { id: `${item.ID}` }
  }))
  return {
    paths,
    fallback: true
  }
}

export const getStaticProps = ({ params }) => {
  return {
    props: {
      id: params?.id
    }
  }
}

export default InvoicePreview
