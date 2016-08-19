// Generated by CoffeeScript 1.10.0
var coffee, gulp, pug;

gulp = require('gulp');

coffee = require('gulp-coffee');

pug = require('gulp-pug');

gulp.task('build:coffee', function() {
  return gulp.src('src/**/*.coffee').pipe(coffee()).pipe(gulp.dest('dist'));
});

gulp.task('build:pug', function() {
  return gulp.src('src/**/*.jade').pipe(pug()).pipe(gulp.dest('dist'));
});

gulp.task('build', ['build:coffee', 'build:pug']);
