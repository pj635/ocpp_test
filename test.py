import asyncio
import json
import logging
from datetime import datetime, timedelta
from time import sleep

import pytest
from websockets.legacy.server import WebSocketServer
import websockets

from ocpp.v16 import call
from ocpp.v16.enums import RegistrationStatus, ResetType

from server.connect import on_connect, Value

loop = None

async def main():
    server: WebSocketServer = await websockets.serve(on_connect, '0.0.0.0', 9000, subprotocols=['ocpp1.6'])
    logging.info("Server Started listening to new connections...")
    while Value.flag_boot_notification == 0:
        await asyncio.sleep(1)


    await asyncio.sleep(1000)
    server.close()







if __name__ == '__main__':
    try:
        # asyncio.run() is used when running this example with Python 3.7 and
        # higher.
        asyncio.run(main())
    except AttributeError:
        # For Python 3.6 a bit more code is required to run the main() task on
        # an event loop.
        loop = asyncio.get_event_loop()
        loop.run_until_complete(main())
        loop.close()