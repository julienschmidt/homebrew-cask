cask 'nomachine' do
  version '5.3.10_1'
  sha256 '66af32d921ebbdecadfc72e1dda074b63bc6857b092111f70240fc440686df41'

  url "http://download.nomachine.com/download/#{version.major_minor}/MacOSX/nomachine_#{version}.dmg"
  name 'NoMachine'
  homepage 'https://www.nomachine.com/'

  pkg 'NoMachine.pkg'

  # a launchctl job ordinarily manages uninstall once the app bundle is removed

  uninstall delete: '/Applications/NoMachine.app'

  # however, we duplicate the uninstall process manually in the zap stanza just in case
  zap early_script: {
                      executable: '/bin/rm',
                      args:       ['-f', '--', '/Library/Application Support/NoMachine/nxuninstall.sh'],
                    },
      quit:         'com.nomachine.nxdock',
      kext:         [
                      'com.nomachine.driver.nxau',
                      'com.nomachine.driver.nxtun',
                      'com.nomachine.kext.nxfs',
                    ],
      pkgutil:      'com.nomachine.nomachine.NoMachine.*',
      launchctl:    'com.nomachine.uninstall'
end
