from langchain_openai import ChatOpenAI
from browser_use import Agent
from dotenv import load_dotenv
import asyncio
import os
import requests
import json
from pydantic import SecretStr
from typing import Any


# dotenv
load_dotenv()

api_key = os.getenv("DEEPSEEK_API_KEY", "")
if not api_key:
    raise ValueError("DEEPSEEK_API_KEY is not set")

llm: Any = ChatOpenAI(
    base_url="https://api.deepseek.com",
    model="deepseek-chat",
    api_key=SecretStr(api_key),
)


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


async def main():
    agent = Agent(
        task="Compare the price of gpt-4o and DeepSeek-V3", llm=llm, use_vision=False
    )
    result = await agent.run()
    print(result)

    # 自动发送结果到飞书群聊
    print("\n📤 正在发送结果到飞书群聊...")
    send_to_feishu(str(result))


asyncio.run(main())
