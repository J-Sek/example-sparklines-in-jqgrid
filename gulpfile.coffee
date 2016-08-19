st      = require 'st'
http    = require 'http'
gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
pug     = require 'gulp-pug'
livereload = require 'gulp-livereload'

gulp.task 'build:coffee', ->
    gulp.src 'src/**/*.coffee'
        .pipe coffee()
        .pipe gulp.dest 'dist'
        .pipe livereload()

gulp.task 'build:pug', ->
    gulp.src 'src/**/*.jade'
        .pipe pug()
        .pipe gulp.dest 'dist'
        .pipe livereload()

gulp.task 'copy:js', ->
    gulp.src 'src/**/*.js'
        .pipe gulp.dest 'dist'
        .pipe livereload()

gulp.task 'copy:css', ->
    gulp.src 'src/**/*.css'
        .pipe gulp.dest 'dist'
        .pipe livereload()

gulp.task 'copy:libs', ->
    gulp.src([
            'libs/jquery-ui/themes/base/jquery-ui.css'
            'libs/jqGrid/css/ui.jqgrid.css'
            'libs/jqGrid/css/ui.jqgrid-bootstrap.css'
            'libs/jqGrid/css/ui.jqgrid-bootstrap-ui.css'

            'libs/jquery/dist/jquery.js'
            'libs/jqGrid/js/jquery.jqGrid.js'
            'libs/highcharts/highcharts.js'
        ])
        .pipe gulp.dest 'dist/libs'

gulp.task 'copy:images', ->
    gulp.src 'libs/jquery-ui/themes/base/images/**/*.*'
        .pipe gulp.dest 'dist/libs/images'

gulp.task 'copy:fonts', ->
    gulp.src 'libs/bootstrap/dist/fonts/**/*.*'
        .pipe gulp.dest 'dist/fonts'

gulp.task 'copy', [
        'copy:js'
        'copy:css'
        'copy:libs'
        'copy:images'
        'copy:fonts'
    ]

gulp.task 'build', [
        'build:coffee'
        'build:pug'
        'copy'
    ]

gulp.task 'server', ['build'], (done) ->
    port = 8081
    console.log "Server ready for requests: http://localhost:#{port}/"
    http.createServer st
            path  : __dirname + '/dist' 
            index : 'index.html'
            cache : false
        .listen port, done

gulp.task 'watch', ['server'], ->
    livereload.listen basePath: 'dist'
    gulp.watch 'src/**/*.jade',    ['build:pug']
    gulp.watch 'src/**/*.coffee',  ['build:coffee']
    gulp.watch 'src/**/*.js',      ['copy:js']
    gulp.watch 'src/**/*.css',     ['copy:css']