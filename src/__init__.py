"""
Browser-Use Project

A Python browser automation project using DeepSeek AI and browser-use library.
"""

__version__ = "1.0.0"
__author__ = "Your Name"
__email__ = "your.email@example.com"

# 导出主要模块
from .agent import main as run_agent
from .clipboard import main as run_clipboard
from .notify_bugs import main as run_notify_bugs
from .pause_agent import main as run_pause_agent

__all__ = [
    "run_agent",
    "run_clipboard",
    "run_notify_bugs",
    "run_pause_agent",
]
