project('io.github.danirabbit.voiceshark', 'vala', 'c')

gnome = import('gnome')

granite_dep = dependency('granite-7')
gtk_dep = dependency('gtk4')

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    'src' / 'MainWindow.vala',
    dependencies: [
        granite_dep,
        gtk_dep
    ],
    install: true
)

gnome.post_install(glib_compile_schemas: true)

subdir('data')
