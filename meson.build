project('io.github.danirabbit.voiceshark', 'vala', 'c')

add_global_arguments('-DGETTEXT_PACKAGE="' + meson.project_name() + '"', language:'c')

gnome = import('gnome')
i18n = import('i18n')

granite_dep = dependency('granite-7')
gtk_dep = dependency('gtk4')
portal_dep = [dependency('libportal'), dependency('libportal-gtk4')]

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    'src' / 'MainWindow.vala',
    dependencies: [
        granite_dep,
        gtk_dep,
        portal_dep
    ],
    install: true
)

gnome.post_install(glib_compile_schemas: true)

subdir('data')
subdir('po')
