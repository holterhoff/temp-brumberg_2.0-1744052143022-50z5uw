export const baseurl =
  process.env.NODE_ENV === 'production'
    ? 'https://brumberg-2-0.vercel.app' // <-- your domain on live
    : 'https://brumberg-2-0.vercel.app' // localhost on dev
