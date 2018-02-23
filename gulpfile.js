var browserSync = require('browser-sync');
var del         = require('del');
var electron    = require('electron-connect').server.create();
var gulp        = require('gulp');
var elm         = require('gulp-elm');
var plumber     = require('gulp-plumber');
var rename      = require('gulp-rename');
var run         = require('gulp-run');
var sass        = require('gulp-sass');


var paths = {
    dest: 'dist',
    elm: 'src/Main.elm',
    js: 'src/*.js',
    sass: 'src/sass/*.scss',
    staticAssets: 'src/static/*.html'
}

/**
 * Task Lists
 */
gulp.task('build', ['elm', 'staticAssets', 'js', 'sass']);

/**
 * Clean output directory.
 */
gulp.task('clean', function(cb){
    del([paths.dest], cb); //What is cb?
});

/**
 * Handle SCSS files.
 */
gulp.task('sass', function(){
    return gulp.src(paths.sass)
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest(paths.dest + "/css"))
        .pipe(browserSync.reload({stream:true}));
});

/**
 * Handle HTML files.
 */
gulp.task('staticAssets', function(){
    return gulp.src(paths.staticAssets)
        .pipe(plumber())
        .pipe(gulp.dest(paths.dest))
        .pipe(browserSync.reload({stream:true}));
});

/**
 * Handle Elm files.
 */
gulp.task('elm-init', elm.init);
gulp.task('elm', ['elm-init'], function(){
    return gulp.src(paths.elm)
        .pipe(plumber())
        .pipe(elm.bundle('main.js'))
        .pipe(gulp.dest(paths.dest))
        .pipe(browserSync.reload({stream:true}));
});

/**
 * Handle Javascript files.
 */
gulp.task('js', function(){
    return gulp.src(paths.js)
        .pipe(plumber())
        .pipe(gulp.dest(paths.dest))
        .pipe(browserSync.reload({stream:true}));
});

/**
 * Run Electron.
 */
gulp.task('run', ['build', 'watch'], function(){
    electron.start();
    //return run('electron main-electron.js').exec();
});

/**
 * Watch for file changes.
 */
gulp.task('watch', function(){
    gulp.watch([paths.sass], ['sass']);
    gulp.watch([paths.staticAssets], ['staticAssets']);
    gulp.watch([paths.elm], ['elm']);
    gulp.watch([paths.js], ['js']);
});
