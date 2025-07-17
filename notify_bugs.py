import asyncio
import os
import json
import requests
from typing import Any

from dotenv import load_dotenv
from langchain_openai import ChatOpenAI
from pydantic import BaseModel, SecretStr

from browser_use.agent.service import Agent
from browser_use.controller.service import Controller


# dotenv
load_dotenv()
api_key = os.getenv("DEEPSEEK_API_KEY", "")
if not api_key:
    raise ValueError("DEEPSEEK_API_KEY is not set")

controller = Controller()


def send_to_feishu(
    message,
    webhook_url="https://open.feishu.cn/open-apis/bot/v2/hook/98ea4ecf-1b50-492e-a9e9-48a66b40ca15",
):
    """发送消息到飞书群聊"""
    try:
        payload = {"msg_type": "text", "content": {"text": message}}

        headers = {"Content-Type": "application/json"}

        response = requests.post(webhook_url, headers=headers, data=json.dumps(payload))

        if response.status_code == 200:
            print("✅ 消息已成功发送到飞书群聊")
        else:
            print(f"❌ 发送失败，状态码：{response.status_code}")
            print(f"响应内容：{response.text}")

    except Exception as e:
        print(f"❌ 发送消息时出错：{str(e)}")


class WebpageInfo(BaseModel):
    """Model for webpage link."""

    link: str = "http://10.89.33.27/zentao/my/"


@controller.action("Go to the webpage", param_model=WebpageInfo)
def go_to_webpage(webpage_info: WebpageInfo):
    """Returns the webpage link."""
    return webpage_info.link


@controller.registry.action("Send message to feishu")
def send_message_to_feishu(message: str):
    """Send message to feishu."""
    return send_to_feishu(message)


llm: Any = ChatOpenAI(
    base_url="https://api.deepseek.com",
    model="deepseek-chat",
    api_key=SecretStr(api_key),
)


async def main():
    """main function"""
    task = (
        "1. 通过我提供的链接打开禅道，登录账号：chenyan，密码：abc.1234"
        "2. 点击左侧导航“地盘”，点击顶部导航“仪表盘”"
        "3. 点击“我的BUG”下的数字跳转到新页面，查看未解决的Bug"
        "4. 如果发现有Bug，则发送消息到飞书群聊，并返回Bug的ID 标题、链接"
    )
    agent = Agent(task=task, llm=llm, controller=controller, use_vision=False)
    await agent.run()


asyncio.run(main())
