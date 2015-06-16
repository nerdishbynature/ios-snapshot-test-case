#!/bin/sh

set -eu

function rome() {
  pod install --no-integrate
  xcodebuild -project Pods/Pods.xcodeproj -scheme Pods -sdk iphonesimulator clean build
}

function ci_lib() {
    xcodebuild -project FBSnapshotTestCase.xcodeproj \
               -scheme FBSnapshotTestCase \
               -sdk iphonesimulator \
               build test
}

function ci_demo() {
    pushd FBSnapshotTestCaseDemo
    pod install
    xcodebuild -workspace FBSnapshotTestCaseDemo.xcworkspace \
               -scheme FBSnapshotTestCaseDemo \
               -destination "platform=iOS Simulator,name=iPhone 6" \
               build test
    popd
}

rome && ci_lib && ci_demo


