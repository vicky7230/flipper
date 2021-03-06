/*
 *  Copyright (c) 2018-present, Facebook, Inc.
 *
 *  This source code is licensed under the MIT license found in the LICENSE
 *  file in the root directory of this source tree.
 *
 */
package com.facebook.flipper.core;

public abstract class ErrorReportingRunnable implements Runnable {

  private final FlipperConnection mConnection;

  public ErrorReportingRunnable(FlipperConnection connection) {
    mConnection = connection;
  }

  @Override
  public final void run() {
    try {
      runOrThrow();
    } catch (Exception e) {
      if (mConnection != null) {
        mConnection.reportError(e);
      }
    } finally {
      doFinally();
    }
  }

  protected void doFinally() {}

  protected abstract void runOrThrow() throws Exception;
}
