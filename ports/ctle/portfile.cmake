vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO mtungekar/ctle
  REF 94dc324f8c50a9de9ebd40771f76bae492f41347
  SHA512 b7b4e4eab3e6148f7804e596f8a254364389cd10a1b1fc9989ebeea586116e7f65f97415f0fa51f0b9f2ae53f9ca870dc4ab0458289166a5867d2b896d0aaa4a
  HEAD_REF main
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

# Put the license file where vcpkg expects it

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)