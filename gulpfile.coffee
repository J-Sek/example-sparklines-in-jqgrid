st      = require 'st'
http    = require 'http'
path    = require 'path'
gulp    = require 'gulp'
through = require 'through2'
$       = require('gulp-load-plugins')()

gulp.task 'build:coffee', ->
    gulp.src 'src/**/*.coffee'
        .pipe $.plumber
            errorHandler:
                $.notify.onError
                    title: 'Cannot compile CoffeeScript'
                    message: '<%= error.message %>'
        .pipe $.coffee()
        .pipe gulp.dest 'dist'
        .pipe $.livereload()

gulp.task 'lint:coffee', ->
    formatter = (file) ->
        file.coffeelint.results
            .getErrors(file.relative)
            .map (err) -> "#{file.relative}|\##{err.lineNumber}: #{err.context or err.message}"
            .join '\n'

    gulp.src 'src/**/*.coffee'
        .pipe $.plumber
            errorHandler:
                $.notify.onError
                    title: '<%= error.message.split("|")[0] %>'
                    message: '<%= error.message.split("|")[1] %>'
        .pipe $.coffeelint()
        .pipe $.coffeelint.reporter('coffeelint-stylish')
        .pipe through.obj (file, enc, cb) ->
            unless file.coffeelint.success
                @emit 'error', new $.util.PluginError 'gulp-coffeelint', formatter(file)
            cb()
            

gulp.task 'lint:js', ->
    gulp.src 'src/**/*.js'
        .pipe $.plumber
            errorHandler:
                $.notify.onError
                    title: 'Invalid JavaScript'
                    message: '<%= error.message %>'
        .pipe $.eslint()
        .pipe $.eslint.format()
        .pipe $.eslint.failAfterError()

gulp.task 'build:pug', ->
    gulp.src 'src/**/*.jade'
        .pipe $.pug()
        .pipe gulp.dest 'dist'
        .pipe $.livereload()

gulp.task 'copy:js', ->
    gulp.src 'src/**/*.js'
        .pipe gulp.dest 'dist'
        .pipe $.livereload()

gulp.task 'copy:css', ->
    gulp.src 'src/**/*.css'
        .pipe gulp.dest 'dist'
        .pipe $.livereload()

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

gulp.task 'lint', [
        'lint:coffee'
        'lint:js'
    ]

gulp.task 'build', [
        'build:coffee'
        'build:pug'
        'lint'
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
    $.livereload.listen basePath: 'dist'
    gulp.watch 'src/**/*.jade',    ['build:pug']
    gulp.watch 'src/**/*.coffee',  ['build:coffee', 'lint:coffee']
    gulp.watch 'src/**/*.js',      ['copy:js', 'lint:js']
    gulp.watch 'src/**/*.css',     ['copy:css']