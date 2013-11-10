module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    browserify: {
      'public/app.js': ['client/app.js']
    },
    nodemon: {
      dev: {
        options: {
          file: 'server.js',
          ignoredFiles: ['README.md', 'node_modules/**'],
          watchedExtensions: ['js', 'coffee'],
          delayTime: 1,
          legacyWatch: true,
          env: {
            PORT: '3001'
          },
          cwd: __dirname
        }
      },
    },
    watch: {
      files: [ "client/**/*.js"],
      tasks: [ 'browserify' ]
    }
  });

  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-nodemon');
};

