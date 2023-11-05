project('io.github.danirabbit.voiceshark', 'vala', 'c')

add_global_arguments('-DGETTEXT_PACKAGE="' + meson.project_name() + '"', language:'c')

gnome = import('gnome')
i18n = import('i18n')

granite_dep = dependency('granite-7')
gtk_dep = dependency('gtk4')

subdir('data')

executable(
    meson.project_name(),
    gresource,
    'src' / 'Application.vala',
    'src' / 'FinishPage.vala',
    'src' / 'MainWindow.vala',
    'src' / 'PracticePage.vala',
    'src' / 'StartPage.vala',
    dependencies: [
        granite_dep,
        gtk_dep
    ],
    install: true
)

gnome.post_install(glib_compile_schemas: true)

subdir('po')
