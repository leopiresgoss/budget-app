const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    colors: {
      main: '#3778c2',
      second: '#5fb523',
      black: '#434b54',
      placeholder: 'rgb(107 114 128))',
      'gray-100': 'rgba(243, 244, 246, 1)',
      'gray-500': '#555e67',
      white: '#fff',
      green: '#60b625',
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ],
};
