import os
import sys
from pathlib import Path
from typing import Any

from browser_use.agent.views import ActionResult

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import asyncio

from dotenv import load_dotenv
import pyperclip
from langchain_openai import ChatOpenAI
from pydantic import SecretStr

from browser_use import Agent, Controller
from browser_use.browser.browser import Browser, BrowserConfig
from browser_use.browser.context import BrowserContext

# dotenv
load_dotenv()
api_key = os.getenv("DEEPSEEK_API_KEY", "")
if not api_key:
    raise ValueError("DEEPSEEK_API_KEY is not set")

browser = Browser(
    config=BrowserConfig(
        headless=False,
    )
)
controller = Controller()


@controller.registry.action("Copy text to clipboard")
def copy_to_clipboard(text: str):
    pyperclip.copy(text)
    return ActionResult(extracted_content=text)


@controller.registry.action("Paste text from clipboard")
async def paste_from_clipboard(browser: BrowserContext):
    text = pyperclip.paste()
    # send text to browser
    page = await browser.get_current_page()
    await page.keyboard.type(text)

    return ActionResult(extracted_content=text)


llm: Any = ChatOpenAI(
    base_url="https://api.deepseek.com",
    model="deepseek-chat",
    api_key=SecretStr(api_key),
)


async def main():
    task = (
        # f"搜索上海迪斯尼，并找到位置信息并复制到剪贴板" "打开google地图，粘贴并搜索地址"
        f"搜索上海迪斯尼，并找到位置信息"
        "打开google地图搜索地址"
    )
    agent = Agent(
        task=task,
        llm=llm,
        controller=controller,
        browser=browser,
        use_vision=False,
    )

    await agent.run()
    await browser.close()

    input("Press Enter to close...")


if __name__ == "__main__":
    asyncio.run(main())
