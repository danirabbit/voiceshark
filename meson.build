project('io.github.danirabbit.voiceshark', 'vala', 'c')

granite_dep = dependency('granite-7')
gtk_dep = dependency('gtk4')

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    dependencies: [
        granite_dep,
        gtk_dep
    ],
    install: true
)

subdir('data')
