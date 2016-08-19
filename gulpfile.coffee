gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
pug     = require 'gulp-pug'

gulp.task 'build:coffee', ->
    gulp.src 'src/**/*.coffee'
        .pipe coffee()
        .pipe gulp.dest 'dist'

gulp.task 'build:pug', ->
    gulp.src 'src/**/*.jade'
        .pipe pug()
        .pipe gulp.dest 'dist'

gulp.task 'build', [
    'build:coffee'
    'build:pug'
    ]