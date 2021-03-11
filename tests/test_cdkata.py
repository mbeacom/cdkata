"""Test general module functionality."""
from __future__ import annotations

from cdkata import __version__


def test_version():
    """Test the version string for valid comparison."""
    assert __version__ == "0.0.0"
