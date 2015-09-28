module.exports = function(grunt) {

    grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		
		/**
		 * Sass
		 */
		sass: {
		  dev: {
		    options: {
		      style: 'expanded',
		      sourcemap: 'none',
		    },
		    files: {
		      'wp-content/themes/<PATH_TO_THEME>/style.css': 'wp-content/themes/<PATH_TO_THEME>/scss/style.scss'
		    }
		  }
		},
		
		postcss: {
			options: {
                map: true,
                processors: [
                    require('autoprefixer')({
                        browsers: ['last 10 versions']
                    })
                ]
            },
			dist: {
				src: 'wp-content/themes/<PATH_TO_THEME>/style.css',
			},
		},

		/**
		 * Watch
		 */
		watch: {
			options: {
				spawn: false // add spawn option in watch task
			},
			css: {
				files: 'wp-content/themes/<PATH_TO_THEME>/scss/*.scss',
				tasks: ['sass', 'postcss:dist'],
				options: {
					livereload: true
				}
			},
		}
	});
	
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-autoprefixer');
	grunt.loadNpmTasks('grunt-postcss');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.registerTask('default',['watch']);
}